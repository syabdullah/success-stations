import { createStore, combineReducers } from 'redux';
import updateProfile from '../ReduxReducer';
const rootReducer = combineReducers(
{ updateProfile: updateProfile }
);
const configureStore = () => {
return createStore(rootReducer);
}
export default configureStore;