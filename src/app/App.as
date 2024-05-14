package app {
import flash.events.MouseEvent;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.display.Sprite;
import flash.events.*;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.utils.ByteArray;

import mx.core.WindowedApplication;
import mx.events.FlexEvent;
import mx.events.FlexNativeMenuEvent;

import spark.components.Button;

public class App extends WindowedApplication {
    public var myButton:Button;
    var fileRef = new FileReference();

    public function App() {
        super();

        fileRef.addEventListener(Event.SELECT, onFileSelected);
        fileRef.addEventListener(Event.CANCEL, onCancel);
        fileRef.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        fileRef.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
                onSecurityError);

        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
    }

    private function onCreationComplete(e:FlexEvent):void {
        this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        this.menu.addEventListener(FlexNativeMenuEvent.ITEM_CLICK, onClick);
    }

    private function onClick(event:FlexNativeMenuEvent):void {
        this.myButton.label = "I've been pressed";
        var filter = new FileFilter("csv Files (*.csv)", "*.csv");
        fileRef.browse([filter]);
    }

    public function onFileSelected(evt:Event):void {
        fileRef.addEventListener(ProgressEvent.PROGRESS, onProgress);
        fileRef.addEventListener(Event.COMPLETE, onComplete);
        fileRef.load();
    }

    public function onProgress(evt:ProgressEvent):void {
        trace("Loaded " + evt.bytesLoaded + " of " + evt.bytesTotal + " bytes.");
    }

    public function onComplete(evt:Event):void {
        trace("File was successfully loaded.");
        trace(fileRef.data);
    }

    public function onCancel(evt:Event):void {
        trace("The browse request was canceled by the user.");
    }

    public function onIOError(evt:IOErrorEvent):void {
        trace("There was an IO Error.");
    }

    public function onSecurityError(evt:Event):void {
        trace("There was a security error.");
    }
}
}
