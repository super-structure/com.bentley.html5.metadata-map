# TODO

* [x] Verify comparability with ["chunked" topics](https://www.oxygenxml.com/dita/1.3/specs/archSpec/base/chunking.html)
* [x] Provide warning message in output log for unsupported file types
* [ ] Add parameter to specify name and output folder or the JSON file
* [ ] Ensure that this plugin _only_ runs for HTML5-based output (i.e., _not_ for PDF)
* [ ] Add other query options for other topic metadata?
* [ ] Add filtering options for Resource ID's by other attributes (or should this just be handled via DITAval filtering?)
* [ ] Prevent duplicate keys in JSON? (which would otherwise be allowed as DITA OT doesn't check or care). For example, this can happen if the same file is included in the map more than once.
