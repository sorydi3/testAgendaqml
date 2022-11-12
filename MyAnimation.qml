import QtQuick

Item {


   Rectangle{
       anchors.fill: parent

       id : root

       property int  duration: 1000


       Rectangle {
           id: sky
           width: parent.width
           height: 200
           gradient: Gradient {
               GradientStop { position: 0.0; color: "#0080FF" }
               GradientStop { position: 1.0; color: "#66CCFF" }
           }
       }
       Rectangle {
           id: ground
           anchors.top: sky.bottom
           anchors.bottom: root.bottom
           width: parent.width
           gradient: Gradient {
               GradientStop { position: 0.0; color: "#00FF00" }
               GradientStop { position: 1.0; color: "#00803F" }
           }
       }


       Rectangle {
            id: ball

            width: 100
            height: 100

            radius: 100

            MouseArea {

                anchors.fill: parent

                onClicked: {

                    ball.x = 0
                    ball.y = root.height - ball.height
                    ball.rotation = 0

                    anim.restart();
                }

            }
       }



   }

}
