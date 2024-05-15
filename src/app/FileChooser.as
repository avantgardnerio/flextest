package app {
import flash.events.Event;
import flash.filesystem.File;

import mx.collections.ArrayCollection;

import mx.containers.TitleWindow;
import mx.controls.DataGrid;
import mx.controls.Label;
import mx.events.FlexEvent;
import mx.events.FlexMouseEvent;
import mx.managers.PopUpManager;

public class FileChooser extends TitleWindow {
    public var lblPath: Label;
    public var dgFiles: DataGrid;

    public function FileChooser() {
        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        this.addEventListener(Event.CLOSE, closePopUpWindow);
        this.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, closePopUpWindow);
    }

    private function onCreationComplete(e: FlexEvent):void {
        this.lblPath.text = File.workingDirectory.nativePath;
        var desktopNodes: Array = File.workingDirectory.getDirectoryListing();
        var files: ArrayCollection = new ArrayCollection();
        for each (var node: File in desktopNodes) {
            if (node.isSymbolicLink) continue;
            files.addItem({Name: node.name, Created: node.creationDate})
        }
        this.dgFiles.dataProvider = files;
    }

    private function closePopUpWindow(evt:Event):void {
        PopUpManager.removePopUp(this);
    }
    
}
}
