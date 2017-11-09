--
--  Firstly run a query to generate the bulk of the analysis
--  of file counts per document type
--
select fp.StoredFileTypeID, ft.FilePath, ft.Description, Count(*)
FROM StoredFilePaths fp, StoredFileTypes ft
WHERE fp.StoredFileTypeID = ft.StoredFileTypeID
GROUP BY fp.StoredFileTypeID, ft.FilePath, ft.Description
ORDER BY ft.FilePath, ft.Description;
--
--  Information about CV's and AdminCV's is not found
--  by the above query. Run the query below to get file
--  totals for these types of documents.
--
select 'CVs', count(*) from dbo.VacancyApplications where CVID > 0
union
select 'Admin CVs', count(*) from dbo.VacancyApplications where AdminCVID > 0;
