# FileCenter

File center is an API for easy file saving and retrieving on iOS devices.
It uses a fluent design to specify file and folder structure. Folders do not have to exist and the structure can be created automatically when saving a file. The API also supports downloading(with progress) to the file system. 

The FileCenter Class is the main class for the File Center API. File Center provides easy access to the following base directories. The file center class can be extend to provide more base directories on top of, or in a addition to these base directories. Standard iOS rules apply to this directorys(i.e in regard to the library, documents and temp directory and how they are handled)

*  **FileCenter.library()**
 
*  **FileCenter.documents()**
 
*  **FileCenter.temp()**

        
####Examples:
Saving a file
```
let success = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg").save(jpgImageData)

```
Check if file exists
```
let exists = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg").exists()
```

Retrieving a file
```
let jpgImageData = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg").fetch()

```

Downloading a file
```
 let url = ...

FileCenter.documents().folder("images").file("image.jpg").downloadable(url).failure({ (error: NSError) in
            print("Error Saving File \(error.localizedDescription)")
        }).progress({ (progress: Float) in
            //update UI
        }).success({ (data: NSData) in
            //Do something with the data
        }).save()
```
Listing files and folders in a directory
```
 let filesAndFolders:[String] = FileCenter.documents().folder("images").list()
        let firstItem = FileCenter.documents().folder("images").folder(filesAndFolders.first!)
        let attributes = firstItem.attributes()
        let isFolder = attributes?[NSFileType] as? String == NSFileTypeDirectory
        
```

Renaming files or folders
```
   let isFolderRenamed = FileCenter.documents().folder("images").rename("myImages")
   let isFileRenamed = FileCenter.documents().folder("myImages").file("myFile.png").rename("newName.png")
        
```

Delete a file or folder
```
let file = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg")

if file.isDeletable {
let isDeleted = file.delete()
}
```

Getting file or folder URLs
```
let relativeURL  = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg").url() //Relative to base directory (e.g. Documents, Library, Temp)

let absoluteURL  = FileCenter.documents().folder("images").folder("profileImages").file("image.jpg").fullURL() //absoulute URL on the file system

```


---



All data is downloaded in the background by default a downloaded object will return to the main queue automatically. You can override this behavior by specifying returnToMainThread. Here is an example below.

```
     let url = ...
        FileCenter.documents().folder("images").file("image.jpg").downloadable(url).failure({ (error: NSError) in
            
        }).progress({ (progress: Float) in
            
        }).success({ (data: NSData) in
            
        }).returnToMainThread(false).save()
```

Now when any of the call backs are called they will be called on the background queue.




---


###Advanced

There are options to generate folder and file objects based on paths. 
For instance:

```
let path = "images/myimages/newImages/"
let folder = FileCenter.documents().generateWithPath(path)
```

```
let url = ...
let folder = FileCenter.documents().generateWithURL(url)
```
