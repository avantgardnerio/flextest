package app {
import mx.core.WindowedApplication;
import spark.components.Label;
import flash.events.MouseEvent;

import mx.controls.FlexNativeMenu;
import mx.controls.Menu;
import mx.events.FlexEvent;

import spark.components.Button;
import spark.components.Group;

public class App extends WindowedApplication {
    public var myButton: Button;

    public var menuData:XML;
    public var flexNativeMenu:FlexNativeMenu;
    public var myMenu:Menu;

    public function App() {
        super();
        this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);

        menuData = <root>
            <menuitem label="File">
                <menuitem label="Open"/>
                <menuitem label="Save"/>
            </menuitem>
            <menuitem label="Help"/>
        </root>;
        flexNativeMenu = new FlexNativeMenu();
        flexNativeMenu.dataProvider = menuData;
        flexNativeMenu.labelField = "@label";
        flexNativeMenu.showRoot = false
    }

    override protected function createChildren():void {
        super.createChildren();
        this.menu = flexNativeMenu;
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
