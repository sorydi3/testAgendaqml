import QtQuick

Item {
    property alias textLabel: labelNombre.text
    property alias inputText: textInput.text
    Rectangle{
          width: parent.width
          height: 80
          color: "lightgreen"
          anchors.margins: 10
          radius: 10

          id:containerlabeText

              Text {
                  id: labelNombre
                  text: qsTr("Nombre")
                  anchors.top: containerlabeText.top
                  anchors.left: containerlabeText.left
                  anchors.leftMargin: 10
                   anchors.topMargin: 5
                  //width: agenda.width-10
              }

            Rectangle{
                id:textInput
                width: agenda.width-20
                height: 30
                anchors{
                    top: labelNombre.bottom
                    //left: agenda.left
                    //right: agenda.right
                    margins: 5
                    centerIn: parent
                }

                border.color: "black"

                radius: 5

                TextInput{
                    anchors.fill:parent
                    //width: parent.width
                    //height: 30
                    id : nombre
                    text: "Nombre"
                    anchors.margins: 5


                }

            }

    }

}
