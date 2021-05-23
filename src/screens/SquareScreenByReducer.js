import React, {useState, useReducer} from "react";
import { View, Text, StyleSheet } from "react-native";
import ColorCounter from '../../components/ColorCounter';

const myReducer = (state, action) => {

    switch (action.colorToChange) {
        case 'red':
            return state.red + action.value > 255 || state.red + action.value < 0 
                  ? state
                  : {...state, red: state.red + action.value}
        case 'green':
            return state.green + action.value > 255 || state.green + action.value < 0 
                  ? state
                  : {...state, green: state.green + action.value}
        case 'blue':
            return state.blue + action.value > 255 || state.blue + action.value < 0 
                  ? state
                  : {...state, blue: state.blue + action.value}
        default:
            return state;

    }
};

const SquareScreenByReducer = () => {

    const [state, action] = useReducer(myReducer, {red: 0, green: 0, blue: 0});

    // const [redColor, setRedColor] = useState(0);
    // const [greenColor, setGreenColor] = useState(0);
    // const [blueColor, setBlueColor] = useState(0);

    const CONSTANT_VALUE = 15
    console.log("Reducer Apporach Red Color:::", state.red);
    console.log("Reducer Apporach Green Color:::", state.green);
    console.log("Reducer Apporach Blue Color:::", state.blue);

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
                    onIncrease = {() => action({colorToChange: 'red', value: CONSTANT_VALUE})}
                    onDecrease = {() => action({colorToChange: 'red', value: -1 * CONSTANT_VALUE})}
                />
                <ColorCounter
                    color = "Green"
                    onIncrease = {() => action({colorToChange: 'green', value: CONSTANT_VALUE})}
                    onDecrease = {() => action({colorToChange: 'green', value: -1 * CONSTANT_VALUE})} 
                />
                <ColorCounter
                    color = "Blue"
                    onIncrease = {() => action({colorToChange: 'blue', value: CONSTANT_VALUE})}
                    onDecrease = {() => action({colorToChange: 'blue', value: -1 * CONSTANT_VALUE})}  
                />
            </View>
            <View style={{backgroundColor: `rgb(${state.red},${state.green},${state.blue})`, height: 100, width: 100}}></View>
        </View>
        

    )
};



const style = StyleSheet.create({

});

export default SquareScreenByReducer;