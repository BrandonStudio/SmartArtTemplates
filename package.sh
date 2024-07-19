#!/bin/sh
for file in diagrams/*.xml; do
	base_name=$(basename "$file" .xml)
	mkdir -p ".release/$base_name/diagrams"
	cp "$file" ".release/$base_name/diagrams/layout1.xml"
	cp -r _rels ".release/$base_name/"
	cp '[Content_Types].xml' ".release/$base_name/"
	cd ".release/$base_name"
	zip -r "${base_name}.glox" .
	cp "${base_name}.glox" ../
	cd ../..
	rm -rf ".release/$base_name"
done
