import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Agenda")
    id:ventana


    Text {
        id: title
        text: qsTr("AGENDA")
        font.family: "Segoe UI Black"
        font.pointSize: 30
        anchors.left: ventana.left
    }

    Rectangle{

        width: 100
        height: 50
        radius: 10
        color: Qt.lighter("red")

        anchors{

            bottom: agenda.top
            right: agenda.right
            margins: 10



        }


        Text {
            id: bText
            text: qsTr("Buscar")
            anchors.centerIn: parent
            font.pointSize: 15
            color: "white"
        }

        MouseArea {
            anchors.fill: parent

            onClicked: {
                console.log("mouse clicked");
                contacto.visible = !contacto.visible
                address.visible = !address.visible
            }

        }

    }


    state: State {
        name: "colum"
        [
        PropertyChanges {
            target: agenda
        }

        PropertyChanges {
            target: address
        }

        PropertyChanges {
            target: contacto
        }
        ]

    }


    


    Column {

        id:agenda
        y:60
        width: parent.width-30


        anchors.margins: 5

        spacing: 15

        anchors.centerIn: parent


        LabelAndInput{
            id : nombre
            z:1
        }

        Rectangle{
            height: 30
            width: parent.width

        }

        LabelAndInput{
            id : contacto
        }

        LabelAndInput{
           id: address

        }

    }
}
