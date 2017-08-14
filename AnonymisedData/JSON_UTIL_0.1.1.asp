<<<<<<< HEAD
<%
Function QueryToJSON(dbc, sql)
        Dim rs, jsa
        Set rs = dbc.Execute(sql)
        Set jsa = jsArray()
        While Not (rs.EOF Or rs.BOF)
                Set jsa(Null) = jsObject()
                For Each col In rs.Fields
                        jsa(Null)(col.Name) = col.Value
                Next
        rs.MoveNext
        Wend
        Set QueryToJSON = jsa
End Function
=======
<%
Function QueryToJSON(dbc, sql)
        Dim rs, jsa
        Set rs = dbc.Execute(sql)
        Set jsa = jsArray()
        While Not (rs.EOF Or rs.BOF)
                Set jsa(Null) = jsObject()
                For Each col In rs.Fields
                        jsa(Null)(col.Name) = col.Value
                Next
        rs.MoveNext
        Wend
        Set QueryToJSON = jsa
End Function
>>>>>>> 0104ec4e7ab52d8fdbcea8b9efc1d52c7c9d89f8
%>