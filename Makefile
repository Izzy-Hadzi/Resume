generate_html:
	@echo "Generating resume.html"
	@java -jar ~/Downloads/SaxonHE11-3J/saxon-he-11.3.jar -s:xml/Tech_resume.xml -xsl:xslt/resume2html.xsl -o:test.html