// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

var bw = Ti.UI.createWindow({
    backgroundColor : 'white'
});

var w = Ti.UI.createWindow({
    backgroundColor : 'white',
    title : "ciDocOpener Test App"
});

var ng = Ti.UI.iPhone.createNavigationGroup({
    window : w
});

// TODO: write your module tests here
var ciDocOpener = require("com.ci.docOpener");
Ti.API.info("module is => " + ciDocOpener);

var f, tempFile, button_pdf, button_ppt, image_view;
image_view = Ti.UI.createView({
    top : 0,
    left : 0,
    height : 77,
    width : 320,
    backgroundImage : 'new_logo.jpg'
});
w.add(image_view);

// buttons
button_pdf = Ti.UI.createButton({
    top : 100,
    left : 90,
    height : 30,
    width : 150,
    title : "View PDF"
});
w.add(button_pdf);
button_ppt = Ti.UI.createButton({
    top : 150,
    left : 90,
    height : 30,
    width : 150,
    title : "View PPT"
});
w.add(button_ppt);

button_pdf.addEventListener('click', function(e) {
    f = Titanium.Filesystem.getFile('Module_Developers_Guide_iOS.pdf');
    tempFile = Titanium.Filesystem.getFile(Titanium.Filesystem.applicationDataDirectory, 'Module_Developers_Guide_iOS.pdf');
    tempFile.write(f.read());

    ciDocOpener.useDocumentOpener({
        path : tempFile.nativePath
    });
});

button_ppt.addEventListener('click', function(e) {
    f = Titanium.Filesystem.getFile('280.ppt');
    tempFile = Titanium.Filesystem.getFile(Titanium.Filesystem.applicationDataDirectory, '280.ppt');
    tempFile.write(f.read());

    ciDocOpener.useDocumentOpener({
        path : tempFile.nativePath
    });
});

bw.add(ng);
bw.open();
