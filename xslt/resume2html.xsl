<?xml version="1.0" encoding="UTF-8"?>
<!--RUN COMMAND: java -jar ~/Downloads/SaxonHE11-3J/saxon-he-11.3.jar -s:xml/Tech_resume.xml -xsl:xslt/resume2html.xsl -o:test.html
-->
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:personal="https://github.com/Izzy-Hadzi/resume">
    
    <xsl:function name="personal:capitalize-word" as="xs:string">
        <xsl:param name="original" as="xs:string"/>
        <xsl:sequence select="concat(substring($original, 1, 1) => upper-case(), substring($original, 2, string-length($original)) =>lower-case()) "/>
    </xsl:function>

    <xsl:template match="resume">
        <html>
            <link rel="stylesheet" href="../css/styling_resume.css"/>
            <body>
                <div class="header">
                <h1 class="name"><xsl:apply-templates select="about/name"/></h1>
                <h2 class="title"><xsl:apply-templates select="about/title"/></h2>
                </div>
                <aside><p><xsl:apply-templates select="about"/></p></aside>
                <div/>
                <section>
                    <h3 class="education">Education</h3>
                    <xsl:apply-templates select="educations"/>
                </section>
                <div/>
                <section>
                    <h3 class="experience">Experience</h3>
                    <xsl:apply-templates select="experiences"/>
                </section>
                <div/>
                <section>
                    <h3 class="projects">Projects</h3>
                    <xsl:apply-templates select="projects"/>
                </section>
                <div/>
                <section>
                    <h3>Skills</h3>
                    <xsl:apply-templates select="skills"/>
                </section>
                <aside>
                    <h3 class="awards">Awards</h3>
                    <p><xsl:apply-templates select="awards"/></p>
                </aside>
                <aside>
                    <h3>Languages</h3>
                    <p><xsl:apply-templates select="languages"/></p>
                </aside>
                <footer>
                    <p>This is a footer</p>
                </footer>
            </body>
            
       </html>
    </xsl:template>

    <xsl:template match="education">
        <h4>
            <strong>
                <xsl:sequence select="school"></xsl:sequence>
            </strong>
            <xsl:text>, </xsl:text>
            <em>
                <xsl:sequence select="city"></xsl:sequence>, <xsl:sequence select="country"/>
            </em>
            <xsl:text> - </xsl:text>
            <xsl:sequence select="degree"/>
        </h4>
        <p>
            <em>
                <xsl:apply-templates select="start-date"/>
                <xsl:text>-</xsl:text> 
                <xsl:choose>
                    <xsl:when test="end-date">
                        <xsl:apply-templates select="end-date"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Current</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </em>
        </p>
        <p><xsl:apply-templates select="description"/></p>
    </xsl:template>
    
    <xsl:template match="experience">
        <h4><strong><xsl:sequence select="title/string()"/></strong></h4>
        <p>
            <em>
                <xsl:apply-templates select="start-date"/>
                <xsl:text>-</xsl:text> 
                <xsl:choose>
                    <xsl:when test="end-date">
                        <xsl:apply-templates select="end-date"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Current</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </em>
        </p>
        <p><xsl:apply-templates select="description"/></p>
    </xsl:template>

    <xsl:template match="skills">
        <xsl:for-each-group select= "skill" group-by="@type/string()">
            <p><xsl:sequence select="current-group()[1]/@type/string() => personal:capitalize-word()"></xsl:sequence>
            <xsl:text>: </xsl:text>
            <xsl:sequence select="string-join(current-group(), ', ')"/>
            </p>
        </xsl:for-each-group>
    </xsl:template>

    <xsl:template match="start-date|end-date">
        <xsl:sequence select="month"/>
        <xsl:sequence select="year"/>
    </xsl:template>

    <xsl:template match="description">
        <xsl:choose>
            <xsl:when test="task[1]">
                <ul>
                    <xsl:apply-templates select="task"/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="task">
        <li>
            <xsl:sequence select="."/>
        </li>
    </xsl:template>
</xsl:stylesheet>