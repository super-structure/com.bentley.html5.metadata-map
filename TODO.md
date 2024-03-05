# TODO

* [x] Verify comparability with ["chunked" topics](https://www.oxygenxml.com/dita/1.3/specs/archSpec/base/chunking.html)
* [x] Provide warning message in output log for unsupported file types
* [x] Add parameter to specify name and output folder or the JSON file
* [x] Ensure that this plugin _only_ runs for HTML5-based output (i.e., _not_ for PDF)
* [x] Use xml-to-json XPATH functions in XSLT 3.0 (also can use parsing and serializing to condense the otherwise sparse file!)

Reference: [Transforming JSON using XSLT 3.0](https://www.saxonica.com/papers/xmlprague-2016mhk.pdf). Michael Kay. 2016.

## Accommodate deep links to IDs

2023-12-20 request from Bill Genemaras - can we handle links to sections or other IDs within a topic?

* [ ] some method for identifying this in the <resourceid> element? Or in the 'target' section / element?

## Duplicate keys

Prevent duplicate keys in JSON? (which would otherwise be allowed as DITA OT doesn't check or care). For example, this can happen if the same file is included in the map more than once.

* [ ] use for-each-group and sequence to build the intermediate XML file.
* [x] For now, re-structured the output JSON to place each key:value pair within an group (array), so there can be duplicates. [https://softwareengineering.stackexchange.com/questions/321534/what-json-structure-to-use-for-key-value-pairs](https://softwareengineering.stackexchange.com/questions/321534/what-json-structure-to-use-for-key-value-pairs)

## Possible future features

* [ ] Add other query options for other topic metadata?
* [ ] Add filtering options for Resource ID's by other attributes (or should this just be handled via DITAval filtering?)
