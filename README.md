![Bentley logo](image/bentley_logo.svg)
# Metadata Map Builder for HTML5 output

DITA Open Toolkit plug-in for generating a JSON file map of Resource ID values with the output html files.

## Installation

1. Download or clone this repository to your DITA OT `plugins` directory.
2. Run the `dita --install` command.

**Note:** This plug-in requires the org.dita.html5 plugin, which is included by default in most distributions of the DITA Open Toolkit.

## Usage

Include a `<resourceid>` element within the `<prolog>` in at least one DITA topic. A JSON file will be generated in your output directory with a list of each  `<resourceid>` element `@id` value as a key and the relative path to the output HTML file.

The relative URLs in the JSON file values are relative to the input DITA map (regardless of the `args.metadata-map.outdir` value).

[LwDITA](https://www.dita-ot.org/4.1/topics/lwdita-input) and [Markdown](https://www.dita-ot.org/4.1/topics/markdown-input) input are _not_ supported, nor are the likely to be. In the case of XDITA and HDITA, it is not clear how the authors of these formats intended for a resource identifier to be included as metadata, if at all. For MDITA and Markdown, the current DITA Open Toolkit plugins (as of 4.1.2) do not seem to correctly parse the YAML metadata block as described in the DITA OT documentation. Thus, it seems reasonable that if a resource identifier needs to be mapped to a topic for post-processing of some sort, then using a standard DITA XML format for topics is warranted. 

## Parameters

`args.metadata-map.name`
: The stem name of the resulting JSON file

`args.metadata-map.outdir`
: The name of the sub-directory of the resulting JSON file. This is _relative_ to output `out` sub-directory. 
: **Tip:** Use a value of . to place the JSON file in the `\out`  sub-directory.

## Reference

DITA Open Toolkit Docs: [Creating custom plug-ins](https://www.dita-ot.org/4.1/topics/custom-plugins)

## Roadmap

Refer to [TODO.md](TODO.md) for details.

## Copyright

Copyright © Bentley Systems, Incorporated. All rights reserved.

## License

MIT License