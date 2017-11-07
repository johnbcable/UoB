
SELECT 'INSERT INTO WORKLINKDATA (StudentID,StudentIDModDate,
StudentExpiryDate,StudentExpiryModDate,StudentTitle,StudentForename,StudentSurname,StudentGender,
StudentAddress1, StudentAddress2, StudentAddress3, StudentTown, StudentCounty, StudentCountry,
StudentPostCode, StudentTelephone, StudentEmail, StudentEthnicOrigin,
StudentDOB,StudentNINO,StudentModDate)
                                                        VALUES ( '
                          + CONVERT(varchar(20), studentid) + ' , ' + 
						  'to_date(' + ' ''' + CONVERT(VARCHAR(10), ISNULL(studentidmoddate, '1900-01-01'), 120)
                         + '''' + ',' + '''' + 'YYYY-MM-DD' + '''' + '), ' +
						 'to_date(' + ' ''' + CONVERT(VARCHAR(10), ISNULL(studentexpirydate, '1900-01-01'), 120)
                         + '''' + ',' + '''' + 'YYYY-MM-DD' + '''' + '), ' +
						 'to_date(' + ' ''' + CONVERT(VARCHAR(10), ISNULL(studentidexpirymoddate, '1900-01-01'), 120)
                         + '''' + ',' + '''' + 'YYYY-MM-DD' + '''' + '), ' +
                         ISNULL(QUOTENAME(title, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(firstname, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(surname, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(gender, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(address1, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(address2, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(address3, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(town, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(county, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(country, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(postcode, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(telephone, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(email, ''''''), '''''') + ' , ' +
                         ISNULL(QUOTENAME(ethnicorigin, ''''''), '''''') + ' , ' +
                         'to_date(' + ' ''' + CONVERT(VARCHAR(10), ISNULL(dateofbirth,
                         '1900-01-01'), 120) + '''' + ',' + '''' + 'YYYY-MM-DD' + '''' + '), ' +
						 ISNULL(QUOTENAME(nino, ''''''), '') + ' , ' +
						 'to_date(' + ' ''' + CONVERT(VARCHAR(10), ISNULL(Candidate_ModDate, '1900-01-01'), 120) + '''' + ',' + '''' + 'YYYY-MM-DD'  + '''' + ' )); '  AS insertcommand
FROM            dbo.WORKLINKDATA
WHERE        (ISNULL(studentid, 0) <> 0)
