#!/bin/bash

set -e

cwd="$(dirname "${BASH_SOURCE[0]}")"
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

cache=(--cache 600s)

assert_not_in_descending_order() {
	printf '%s\n%s' "$1" "$2" | sort -C -V
}

assert_in_ascending_order() {
	! assert_not_in_descending_order "$2" "$1"
}

check_last_release() {
	local repo="$1"
	local last_release
	if ! last_release="$(gh api repos/"${repo}"/releases/latest "${cache[@]}" --jq '.tag_name')"; then
		last_release=""
	fi
	echo "$last_release"
}

fetch_last_release_notes() {
	local repo="$1"
	gh api repos/"${repo}"/releases/latest "${cache[@]}" --jq '.body'
}

check_if_new_release_available() {
	local local_release="$1"
	local upstream_release="$2"
	if [[ -z "$upstream_release" ]]; then
		echo "No upstream release found"
		exit 0
	fi

	if [[ -z "$local_release" ]]; then
		echo "No local release found"
	else
		if [[ "$local_release" == "$upstream_release" ]]; then
			echo "Local release is the same as upstream release"
			exit 0
		fi
		if ! assert_in_ascending_order "$local_release" "$upstream_release"; then
			echo "Local release is newer than upstream release"
			exit 1
		fi
	fi
}

download_asset() {
	printf '%s' "Downloading xcframework ... "

	local repo="$1"
	local asset_name="$2"
	local output="$3"
	local download_url

	download_url="$(gh api repos/"${repo}"/releases/latest "${cache[@]}" \
		--jq ".assets[] | select(.name == \"$asset_name\") | .browser_download_url")"

	curl -sSLf "$download_url" --output "$output"
	echo "✅"
}

update_swift_package() {
	printf '%s' "Updating Package.swift ... "

	export new_version="$1"
	local asset_path="$2"
	export checksum
	checksum=$(swift package compute-checksum "$asset_path")

	envsubst < "${cwd}/assets/Package.swift.in" > "${cwd}/Package.swift"
	echo "✅"
}

make_release() {
	local repo="$1"
	local version="$2"
	local release_notes="$3"
	local asset="$4"

	echo "Making ${version} release ... 🚢"

	git add "${cwd}/Package.swift"
	git commit -m "$release_notes (${version})"
	git tag -m "$release_notes" "$version"
	git push origin main
	git push origin "$version"

	gh release create "$version" --notes "$release_notes" "$asset" --repo "$repo"

	cat <<- EOF

	🎉 Release is ready at https://github.com/${repo}/releases/tag/${new_version}
	EOF
}

main() {
	printf '%s\n' "Using directory at ${workdir}"

	local this_repo
	this_repo="$(gh repo view --json owner,name --jq '(.owner.login) + "/" + (.name)')"
	local upstream_repo="${1:-"krzyzanowskim/OpenSSL"}"
	local xcframework_zip="OpenSSL.xcframework.zip"
	local xcframework_path="${workdir}/${xcframework_zip}"

	local last_local_release
	local last_upstream_release
	last_local_release="$(check_last_release "$this_repo")"
	last_upstream_release="$(check_last_release "$upstream_repo")"

	if ! check_if_new_release_available "$last_local_release" "$last_upstream_release"; then
		echo "No new release available"
		exit 0
	fi

	cat <<-EOF
	Current local version: $last_local_release
	Current upstream version: $last_upstream_release

	Preparing $last_upstream_release release ...

	EOF

	download_asset "$upstream_repo" "$xcframework_zip" "$xcframework_path"
	update_swift_package "$last_upstream_release" "$xcframework_path"

	local release_notes
	release_notes=$(fetch_last_release_notes "$upstream_repo")
	make_release "$this_repo" "$last_upstream_release" "$release_notes" "$xcframework_path"
}

main "$@"
