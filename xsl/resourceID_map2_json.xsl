<?xml version="1.0" encoding="UTF-8"?>
<!-- ******************************************************************************
* XML Stylesheet to output list of all resourceid @ids to a JSON file.
*
* Copyright © Bentley Systems, Incorporated. All rights reserved.
*
****************************************************************************** -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="#all" 
    version="3.0">
    
    <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
    <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"/>
    
    <xsl:param name="dita.temp.dir"/>
    
    <xsl:output method="text"/>
    
    <xsl:template match="/*">
        <xsl:variable name="xml-json-format">
            <map xmlns="http://www.w3.org/2005/xpath-functions">
                <map key="resourcid" xmlns="http://www.w3.org/2005/xpath-functions">
                    <string key="home" xmlns="http://www.w3.org/2005/xpath-functions">index.html</string>
                    <xsl:apply-templates/>
                </map>
            </map>
        </xsl:variable>
        <xsl:result-document href="file:///D:/Projects/ConcreteDesignCenter/docs/out/js/resourceids.xml" method="xml" indent="yes">
            <xsl:copy-of select="$xml-json-format"/>
        </xsl:result-document>
        <!-- Use XPath 3.0 function chaining -->
        <xsl:value-of select="$xml-json-format => xml-to-json() => parse-json() => serialize(map {
            'method': 'json',
            'use-character-maps': map {'/': '/'}
            })"/>
    </xsl:template>
    
    <xsl:template match="//topicref[(contains(@format,'dita') or not(@format)) 
                                     and not(@dita-ot:orig-format)
                                     and not(ancestor::topicref[@chunk='to-content'])]"> <!-- since 'dita' is the default format -->
        <xsl:variable name="dita-target">
            <xsl:choose>
                <xsl:when test="contains(./@href,'#')"><xsl:value-of  select="substring-before(./@href,'#')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="./@href"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="target-stem">
            <xsl:choose>
                <xsl:when test="ends-with($dita-target,'.xml')">
                    <xsl:value-of select="substring-before($dita-target,'.xml')"/>
                </xsl:when>
                <xsl:when test="ends-with($dita-target,'.dita')">
                    <xsl:value-of select="substring-before($dita-target,'.dita')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="topic-contents" select="document($dita-target,.)/*"/>
        <!-- TODO:
            1) use a for-each-group and sequence to prevent duplicate key names in the JSON file?
            2) create a template that can take in the element name in xpath selector & value in 'id'?
        
        -->
        <xsl:for-each select="$topic-contents//resourceid">
            <xsl:call-template name="xml-entry">
                <xsl:with-param name="target" select="$target-stem"/>
                <xsl:with-param name="id" select="current()/@id"/>
            </xsl:call-template>
        </xsl:for-each>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- support for markdown DITA syntax and markdown LwDITA -->
    <xsl:template match="//topicref[contains(@format,'markdown') or contains(@format,'mdita') 
        or contains(@dita-ot:orig-format,'markdown') or contains(@dita-ot:orig-format,'mdita')]">
        <xsl:variable name="target" select="./@href"/>
        <xsl:message>target: <xsl:value-of select="$target"/></xsl:message>
        <xsl:variable name="topic-contents" select="document($target,.)"/> <!-- markdown is already converted to DITA XML at this point -->
        <xsl:if test="contains($topic-contents,'resourceid:')">
            <xsl:call-template name="output-message">
                <xsl:with-param name="id" select="'RSMP001W'"/>
                <xsl:with-param name="msgparams">%1=<xsl:value-of select="$target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        
    </xsl:template>
    
    <!-- support for HTML LwDITA syntax -->
    <xsl:template match="//topicref[contains(@format,'hdita') or contains(@dita-ot:orig-format,'hdita')]">
        <xsl:variable name="target" select="./@href"/>
        <xsl:variable name="topic-contents" select="document($target,.)"/>
        <xsl:if test="contains($topic-contents,'resourceid')">
            <xsl:call-template name="output-message">
                <xsl:with-param name="id" select="'RSMP001W'"/>
                <xsl:with-param name="msgparams">%1=<xsl:value-of select="$target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- support for XML LwDITA syntax -->
    <xsl:template match="//topicref[contains(@format,'xdita') or contains(@dita-ot:orig-format,'xdita')]" priority="10">
        <xsl:variable name="target" select="./@href"/>
        <xsl:variable name="topic-contents" select="document($target,.)"/>
        <xsl:if test="contains($topic-contents,'resourceid')">
            <xsl:call-template name="output-message">
                <xsl:with-param name="id" select="'RSMP001W'"/>
                <xsl:with-param name="msgparams">%1=<xsl:value-of select="$target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="json-entry">    <!-- not used; just let parser convert useing xml-to-json XPath function -->
        <xsl:param name="target"/>
        <xsl:param name="id"/>
        <xsl:text>"</xsl:text><xsl:value-of select="$id"/><xsl:text>" : "</xsl:text><xsl:value-of select="$target || '.html'"/><xsl:text>",&#010;</xsl:text>
    </xsl:template>
    
    <xsl:template name="xml-entry">
        <xsl:param name="target"/>
        <xsl:param name="id"/>
        <string xmlns="http://www.w3.org/2005/xpath-functions">
            <xsl:attribute name="key" select="$id"/>
            <xsl:value-of select="$target || '.html'"/>
        </string>
    </xsl:template>
    
    <xsl:template match="//topicgroup | //topichead">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="//title | //navtitle | //linktext | //shortdesc | //abstract | //keydef //topicmeta"/>
    
</xsl:stylesheet>