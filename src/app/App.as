package app {
import mx.core.WindowedApplication;
import spark.components.Label;
import flash.events.MouseEvent;

import mx.events.FlexEvent;

import spark.components.Button;
import spark.components.Group;

public class App extends WindowedApplication {
    public var myButton: Button;

    public function App() {
        super();
        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
    }

    private function onCreationComplete(e:FlexEvent):void {
        this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        myButton.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(e:MouseEvent):void {
        this.myButton.label = "I've been pressed";
    }
}
}
