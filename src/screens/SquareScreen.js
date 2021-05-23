import React, {useState} from "react";
import { View, Text, StyleSheet } from "react-native";
import ColorCounter from '../../components/ColorCounter';

const SquareScreen = () => {

    const [redColor, setRedColor] = useState(0);
    const [greenColor, setGreenColor] = useState(0);
    const [blueColor, setBlueColor] = useState(0);

    const CONSTANT_VALUE = 15
    
    const setColor = (color, value) => {

        switch (color) {
            case 'red':
                value + redColor > 255 || value + CONSTANT_VALUE < 0 ? null: setRedColor(redColor + value);
                return;
            case 'green':
                value + greenColor > 255 || value + CONSTANT_VALUE < 0 ? null: setGreenColor(greenColor + value);
                return;
            case 'blue':
                value + blueColor > 255 || value + CONSTANT_VALUE < 0 ? null: setBlueColor(blueColor + value);
                return;
            default:
                return;
        }
    };

    return (
        <View>
            <View>
                <ColorCounter 
                    color = "Red"
                    onIncrease = {() => setColor('red', CONSTANT_VALUE)}
                    onDecrease = {() => setColor('red', -1 * CONSTANT_VALUE)}
                />
                <ColorCounter
                    color = "Green"
                    onIncrease = {() => setColor('green', CONSTANT_VALUE)}
                    onDecrease = {() => setColor('green', -1 * CONSTANT_VALUE)} 
                />
                <ColorCounter
                    color = "Blue"
                    onIncrease = {() => setColor('blue', CONSTANT_VALUE)}
                    onDecrease = {() => setColor('blue', -1 * CONSTANT_VALUE)}  
                />
            </View>
            <View style={{backgroundColor: `rgb(${redColor},${greenColor},${blueColor})`, height: 100, width: 100}}></View>
        </View>
        

    )
};



const style = StyleSheet.create({

});

export default SquareScreen;