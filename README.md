![Bentley logo](image/bentley_logo.svg)
# Metadata Map Builder for HTML5 output

DITA Open Toolkit plug-in for generating a JSON file map of Resource ID values with the output html files.

# Installation

1. Download or clone this repository to your DITA OT `plugins` directory.
2. Run the `dita --install` command.

**Note:** This plug-in requires the org.dita.html5 plugin, which is included by default in most distributions of the DITA Open Toolkit.

# Usage

Include a `<resourceid>` element within the `<prolog>` in at least one DITA topic. A JSON file will be generated in your output directory with a list of each  `<resourceid>` element `@id` value as a key and the relative path to the output HTML file.

[LwDITA](https://www.dita-ot.org/4.1/topics/lwdita-input) and [Markdown](https://www.dita-ot.org/4.1/topics/markdown-input) input are _not_ supported, nor are the likely to be. In the case of XDITA and HDITA, it is not clear how the authors of these formats intended for a resource identifier to be included as metadata, if at all. For MDITA and Markdown, the current DITA Open Toolkit does plugins do not seem to correctly parse the YAML metadata block as described in the DITA OT documentation. Thus, it seems reasonable that if a resource identifier needs to be mapped to a topic for post-processing of some sort, then using a standard DITA XML format for topics is warranted. 

# Reference

DITA Open Toolkit Docs: [Creating custom plug-ins](https://www.dita-ot.org/4.1/topics/custom-plugins)

# Roadmap

* [x] Verify comparability with ["chunked" topics](https://www.oxygenxml.com/dita/1.3/specs/archSpec/base/chunking.html)
* [x] Provide warning message in output log for unsupported file types
* [ ] Add parameter to specify name and output folder or the JSON file
* [ ] Add other query options for other topic metadata?
* [ ] Prevent duplicate keys in JSON? (which would otherwise be allowed as DITA OT doesn't check or care). For example, this can happen if the same file is included in the map more than once.

# Copyright

Copyright © Bentley Systems, Incorporated. All rights reserved.

# License

MIT License