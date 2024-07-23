#!/bin/sh
release_prefix=".release"
release_glox_prefix="$release_prefix/glox"
release_pptx_prefix="$release_prefix/pptx"
template_prefix="templates"
template_glox_prefix="$template_prefix/glox"
template_pptx_prefix="$template_prefix/pptx"

package_glox() {
	base_name=$(basename "$1" .xml)
	base_dir="$release_glox_prefix/$base_name"
	mkdir -p "$base_dir/diagrams"
	cp "$1" "$base_dir/diagrams/layout1.xml" || exit 1
	cp -r "$template_glox_prefix/_rels" "$release_glox_prefix/$base_name/" || exit 1
	cp "$template_glox_prefix/[Content_Types].xml" "$release_glox_prefix/$base_name/" || exit 1
	cd "$base_dir" || exit 1
	zip -r "${base_name}.glox" .
	cp "${base_name}.glox" ../
	cd ../../..
	rm -rf "$base_dir"
}

package_pptx() {
	base_name=$(basename "$1" .xml)
	base_dir="$release_pptx_prefix/$base_name"
	mkdir -p "$base_dir"
	cp -r $template_pptx_prefix/* "$base_dir/" || exit 1
	cp "$1" "$base_dir/ppt/diagrams/layout1.xml" || exit 1
	cd "$base_dir" || exit 1
	zip -r "${base_name}.pptx" .
	cp "${base_name}.pptx" ../
	cd ../../.. || exit 1
	rm -rf "$base_dir"
}

for file in diagrams/*.xml; do
	package_glox "$file"
	package_pptx "$file"
done

cur_dir=$(pwd)
cd "$release_glox_prefix" || exit 1
zip -r "_all-glox.zip" .
mv "_all-glox.zip" ../

cd "$cur_dir/$release_pptx_prefix" || exit 1
zip -r "_all-pptx.zip" .
mv "_all-pptx.zip" ../
