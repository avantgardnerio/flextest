package app {
import flash.events.MouseEvent;

import mx.core.WindowedApplication;
import mx.events.FlexEvent;
import mx.events.FlexNativeMenuEvent;

import spark.components.Button;

public class App extends WindowedApplication {
    public var myButton: Button;

    public function App() {
        super();
        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
    }

    private function onCreationComplete(e:FlexEvent):void {
        this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
        this.menu.addEventListener(FlexNativeMenuEvent.ITEM_CLICK, onClick);
    }

    private function onClick(event:FlexNativeMenuEvent):void {
        this.myButton.label = "I've been pressed";
    }
}
}
