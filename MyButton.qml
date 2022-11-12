
import QtQuick
Item {
    id: name
    property alias titleButton : bText.text
     property alias colorButton : container.color
    width:  100
    height: 50

    Rectangle {
        id:container
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ff6434" }
            GradientStop { position: 0.5; color: "#dd2c00" }
            GradientStop { position: 1.0; color: "#ff6434" }
        }


        width: parent.width
        height: parent.height
        radius: 10
        color: "#ba2d65"

        Text {
            id: bText
            text: qsTr("Buscar")
            anchors.centerIn: parent
            font.pointSize: 15
            color: "white"
        }

    }
}
