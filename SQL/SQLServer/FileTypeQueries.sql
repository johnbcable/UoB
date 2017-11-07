select * from  StoredFilePaths where RecordID in (14961);
select * from StoredFileTypes;
select fp.StoredFileTypeID, ft.FilePath, ft.Description, Count(*) 
FROM StoredFilePaths fp, StoredFileTypes ft 
WHERE fp.StoredFileTypeID = ft.StoredFileTypeID 
GROUP BY fp.StoredFileTypeID, ft.FilePath, ft.Description 
ORDER BY ft.FilePath, ft.Description;

 
