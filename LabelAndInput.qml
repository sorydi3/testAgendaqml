import QtQuick

Item {
    width: parent.width/3
    height: containerlabeText.height
    id:mainid
    property alias labeltext : labelNombre.text
    property alias inputText : nombre.text
    property bool clickeable: true
    property var customtarget;

    property var parentwidth: parent.width
    property var parentHeight: parent.height

    property alias maxDragXx: mouseArea.drag.maximumX
    property alias maxDragYy: mouseArea.drag.maximumY

    property alias x_:containerlabeText.x
    property alias y_:containerlabeText.y


    Rectangle{



          width: parent.width
          height: 80
          color: "#32cb00"
          anchors.margins: 10
          radius: 10
          id:containerlabeText
          opacity: (containerlabeText.width*3 - containerlabeText.x) / containerlabeText.width*3

              Text {
                  id: labelNombre
                  text: qsTr("Nombre")
                  anchors.top: containerlabeText.top
                  anchors.left: containerlabeText.left
                  anchors.leftMargin: 10
                   anchors.topMargin: 5

                  //width: agenda.width-10
                   color: "#37474f"
              }

            Rectangle{
                id:textInput
                width: containerlabeText.width-30
                height: 30
                anchors{
                    top: labelNombre.bottom
                    //left: agenda.left
                    //right: agenda.right
                    margins: 5
                    centerIn: parent
                }
               //border.color: "black"



                radius: 5

                TextInput{
                    anchors.fill:parent
                    //width: parent.width
                    //height: 30

                    id : nombre

                    //text: "heyy"
                    anchors.margins: 5

                    font.weight: Font.DemiBold

                    overwriteMode: true

                    persistentSelection:true

                    //validator: Qt.ImhUppercaseOnly

                    inputMethodHints : Qt.ImhUppercaseOnly

                    activeFocusOnPress :true



                    MouseArea{
                        id:area
                        focus: true

                        Connections{
                            target:nombre
                            function accepted(){
                                    console.log("doneeee!!")
                            }

                        }

                        onClicked: {
                            if(!area.focus) textInput.border.color = "red"
                        }

                    }


                }

            }

            MouseArea{
                 id : mouseArea
                 anchors.fill: parent
                 drag.target: containerlabeText
                 hoverEnabled: true
                 cursorShape: Qt.IBeamCursor
                 onClicked: {
                       nombre.focus=mainid.clickeable;
                 }


           }

    }


}
