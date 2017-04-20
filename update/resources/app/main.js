const electron = require('electron')
// Module to control application life.
const app = electron.app


// Module to create native browser window.
const BrowserWindow = electron.BrowserWindow

const path = require('path')
const url = require('url')

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let mainWindow = null;

var shouldQuit = app.makeSingleInstance(function(commandLine, workingDirectory) {
  if (mainWindow) {  // 当另一个实例运行的时候，这里将会被调用，我们需要激活应用的窗口
    if (mainWindow.isMinimized()) mainWindow.restore();
    mainWindow.focus();
  }
  return true;
});

// 这个实例是多余的实例，需要退出
if (shouldQuit) {
  app.quit();
  return;
}


function createWindow () {
  var WindowSize = electron.screen.getPrimaryDisplay().workAreaSize;//获取电脑屏幕窗口
  // Create the browser window.new BrowserWindow 创建一个窗口
  mainWindow = new BrowserWindow({width:WindowSize.width, height:WindowSize.height})
    //mainWindow.maximize()//窗口最大化

  // and load the index.html of the app.mainWindow.loadURL 加载一个url,可以是本地文件或者是远程url.
  //mainWindow.loadURL('http://42.51.158.129/app/main.html')
  mainWindow.loadURL(url.format({
    pathname: path.join(__dirname, 'index.html'),
    protocol: 'file:',
    slashes: true
  }))

  // Open the DevTools.开启调试窗口
  mainWindow.webContents.openDevTools()

  // Emitted when the window is closed.
  mainWindow.on('closed', function () {
    // Dereference the window object, usually you would store windows
    // in an array if your app supports multi windows, this is the time
    // when you should delete the corresponding element.
    mainWindow = null
  })
}

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
// 创建窗口、继续加载应用、应用逻辑等……
app.on('ready', createWindow)

// Quit when all windows are closed.
app.on('window-all-closed', function () {
	mainWindow.webContents.session.clearCache(function(){
//some callback.
});

  // On OS X it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', function () {
  // On OS X it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (mainWindow === null) {
    createWindow()
  }
})

// In this file you can include the rest of your app's specific main process
// code. You can also put them in separate files and require them here.
