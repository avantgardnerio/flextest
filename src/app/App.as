package app {
import flash.events.*;
import flash.net.FileFilter;
import flash.net.FileReference;

import mx.collections.ArrayCollection;
import mx.controls.DataGrid;
import mx.controls.Label;
import mx.core.WindowedApplication;
import mx.events.FlexEvent;

public class App extends WindowedApplication {
    public var lblOpen: Label;
    public var myGrid: DataGrid;
    
    var fileRef = new FileReference();
    public var linedata = new ArrayCollection();

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

        this.lblOpen.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(event: MouseEvent):void {
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
        var content = fileRef.data.toString();
        //var ending:String = new String(“\n\g”);
        // Split the whole file into lines
        var values:Array;
        var lines:Array = content.split("\n");
        trace ("File split into " + lines.length + " lines");
        // Split each line into data content – start from 1 instead of 0 as this is a header line.
        for ( var i: Number=1; i < lines.length; i++ ) {
            var line:String = lines[i];
            values = line.split(",");
            trace("line split in " +values);
            linedata.addItem({incident_id:values[0], offense_type_id:values[4], reported_date:values[8], neighborhood_id:values[16]});
        }
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
