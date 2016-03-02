# MemeMe

The MemeMe is result of **UIKit Fundamentals** lesson of **Udacity's iOS Developer Nanodegree** course.

MemeMe is a meme-generating app that enables a user to attach a caption to a picture from their phone. 
After adding text to an image chosen from the Photo Album or Camera, the user can share it with friends. 
MemeMe also temporarily stores sent memes which users can browse in a table or a grid.

## Implementation

The app has three view controller scenes:

- **EditorController** - consists of an image view overlaid by two text fields, one near the top and one near the bottom of the image. To create meme user should pick photo from the camera or existing photo album.

- **TableController** and **CollectionController** - displays recently sent memes. It has a bottom toolbar with tabs that allow the user to toggle between viewing sent memes in a table and viewing them in a grid. 

- **PreviewController** - displays the selected meme in an image view in the center of the page with the meme’s original aspect ratio. User also be able to share or save meme as file by clicking the appropriate button in the navigation bar.

## Requirements

 - Xcode 7.2
 - Swift 2.0

## License

Copyright (c) 2016 Egor Verbitskiy

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
