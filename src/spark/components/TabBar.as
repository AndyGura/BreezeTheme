package spark.components {
import mx.core.mx_internal;
import mx.managers.IFocusManagerComponent;

import spark.components.supportClasses.ButtonBarBase;

use namespace mx_internal;

[Style(name="cornerRadius", type="Number", format="Length", inherit="no", theme="spark")]
[AccessibilityClass(implementation="spark.accessibility.TabBarAccImpl")]
[DiscouragedForProfile("mobileDevice")]
public class TabBar extends ButtonBarBase implements IFocusManagerComponent {

    mx_internal static var createAccessibilityImplementation:Function;

    [Bindable]
    public var isClosingTabEnabled:Boolean = false;

    [Bindable]
    public var isSwitchOnDragEnabled:Boolean = false;

    public function TabBar() {
        super();
        requireSelection = true;
        mouseFocusEnabled = false;
    }

    override protected function initializeAccessibility():void {
        if (TabBar.createAccessibilityImplementation != null)
            TabBar.createAccessibilityImplementation(this);
    }
}
}