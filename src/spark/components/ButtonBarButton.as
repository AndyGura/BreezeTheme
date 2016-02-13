package spark.components {
import flash.events.DataEvent;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.mx_internal;

use namespace mx_internal;

[Event(name="dataChange", type="mx.events.FlexEvent")]
[Event(name="closeTab", type="flash.events.DataEvent")]

public class ButtonBarButton extends ToggleButton implements IItemRenderer {

    [SkinPart(required="true")]
    public var closeButton:Button;

    public function ButtonBarButton() {
        super();
        closeButton = new Button();
        mouseChildren = true;
        addEventListener(MouseEvent.CLICK, onClick);
        addEventListener(MouseEvent.MIDDLE_CLICK, onClose);
    }

    private var _allowDeselection:Boolean = true;

    public function get allowDeselection():Boolean {
        return _allowDeselection;
    }

    public function set allowDeselection(value:Boolean):void {
        _allowDeselection = value;
    }

    private var _closeEnabled:Boolean = true;

    public function get closeEnabled():Boolean {
        return _closeEnabled;
    }

    public function set closeEnabled(value:Boolean):void {
        _closeEnabled = value;
        closeButton.visible = value;
        closeButton.includeInLayout = value;
    }

    private var _showsCaret:Boolean = false;


    public function get showsCaret():Boolean {
        return _showsCaret;
    }

    public function set showsCaret(value:Boolean):void {
        if (value == _showsCaret)
            return;

        _showsCaret = value;
        drawFocusAnyway = true;
        drawFocus(value);
    }


    public function get dragging():Boolean {
        return false;
    }

    public function set dragging(value:Boolean):void {
    }

    [Bindable("dataChange")]
    public function get data():Object {
        return content;
    }

    public function set data(value:Object):void {
        content = value;
        dispatchEvent(new Event("dataChange"));
    }

    private var _itemIndex:int;

    public function get itemIndex():int {
        return _itemIndex;
    }

    public function set itemIndex(value:int):void {
        _itemIndex = value;
    }

    private var _label:String = "";

    override public function get label():String {
        return _label;
    }

    override public function set label(value:String):void {
        if (value != _label) {
            _label = value;

            if (labelDisplay)
                labelDisplay.text = _label;
        }
    }

    override protected function buttonReleased():void {
        if (selected && !allowDeselection)
            return;
        super.buttonReleased();
    }

    private function onClick(event:MouseEvent):void {
        if (event.target == closeButton) {
            event.stopImmediatePropagation();
            onClose(event);
        }
    }

    private function onClose(event:MouseEvent):void {
        dispatchEvent(new DataEvent("closeTab", true, false, _itemIndex.toString()));
    }
}

}