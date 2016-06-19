package spark.components {
import flash.events.DataEvent;
import flash.events.Event;
import flash.events.MouseEvent;

import mx.core.mx_internal;
import mx.events.DragEvent;
import mx.events.PropertyChangeEvent;

use namespace mx_internal;

[Event(name="dataChange", type="mx.events.FlexEvent")]
[Event(name="closeTab", type="flash.events.DataEvent")]

public class ButtonBarButton extends ToggleButton implements IItemRenderer {

    [SkinPart(required="true")]
    public var closeButton:Button;

    public function ButtonBarButton() {
        super();
        mouseChildren = true;
        addEventListener(MouseEvent.CLICK, onClick);
        addEventListener(MouseEvent.MIDDLE_CLICK, onClose);
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    override protected function attachSkin():void {
        super.attachSkin();
        closeButton.visible = closeEnabled;
        closeButton.includeInLayout = closeEnabled;
    }


    private var _allowDeselection:Boolean = true;

    public function get allowDeselection():Boolean {
        return _allowDeselection;
    }

    public function set allowDeselection(value:Boolean):void {
        _allowDeselection = value;
    }

    public var closeEnabled:Boolean = false;

    public var switchOnDragEnabled:Boolean = false;

    private function onDragOver(event:DragEvent):void {
        dispatchEvent(new MouseEvent(MouseEvent.CLICK));
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
        if (closeEnabled) {
            dispatchEvent(new DataEvent("closeTab", true, false, _itemIndex.toString()));
        }
    }

    private function onPropertyChange(event:PropertyChangeEvent):void {
        if (event.property == 'closeEnabled') {
            if (closeButton) {
                closeButton.visible = event.newValue;
                closeButton.includeInLayout = event.newValue;
            }
        } else if (event.property == 'switchOnDragEnabled') {
            if (event.newValue) {
                addEventListener(DragEvent.DRAG_OVER, onDragOver);
            } else {
                removeEventListener(DragEvent.DRAG_OVER, onDragOver);
            }
        }
    }

    private function onAddedToStage(event:Event):void {
        if (closeButton) {
            closeButton.visible = closeEnabled;
            closeButton.includeInLayout = closeEnabled;
        }
        if (switchOnDragEnabled) {
            addEventListener(DragEvent.DRAG_OVER, onDragOver);
        } else {
            removeEventListener(DragEvent.DRAG_OVER, onDragOver);
        }
    }
}

}