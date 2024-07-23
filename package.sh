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
	cp "$1" "$base_dir/diagrams/layout1.xml"
	cp -r "$template_glox_prefix/_rels" "$release_glox_prefix/$base_name/"
	cp "$template_glox_prefix/[Content_Types].xml" "$release_glox_prefix/$base_name/"
	cd "$base_dir"
	zip -r "${base_name}.glox" .
	cp "${base_name}.glox" ../
	cd ../../..
	rm -rf "$base_dir"
}

for file in diagrams/*.xml; do
	package_glox "$file"
done

cd "$release_glox_prefix"
zip -r "_all-glox.zip" .
mv "_all-glox.zip" ../
