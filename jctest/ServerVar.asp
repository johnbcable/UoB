<<<<<<< HEAD
<%
response.write("<table>")
for each x in Request.ServerVariables
	response.write("<tr><td>" & x & "</td><td>" & Request.ServerVariables(x) & "</td></tr>")
next
response.write("</table>")
response.write("<hr />")
response.Write("<h1>" & "Variables from Global.asa" & "</h1>")
response.write("<table>")
response.write("<tr><td>" & x & "</td><td>" & Application("ALTAHRN") & "</td></tr>")
response.write("</table>")
%>
=======
<%
response.write("<table>")
for each x in Request.ServerVariables
	response.write("<tr><td>" & x & "</td><td>" & Request.ServerVariables(x) & "</td></tr>")
next
response.write("</table>")
response.write("<hr />")
response.Write("<h1>" & "Variables from Global.asa" & "</h1>")
response.write("<table>")
response.write("<tr><td>" & x & "</td><td>" & Application("ALTAHRN") & "</td></tr>")
response.write("</table>")
%>
>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8
