import { PROFILE_IMAGE, LOGOUT, PROFILE_ADDRESS } from './ReduxConstants';
const initialState = {
url: '',
address:'',
isLogout:false,
};
export default function updateProfile(state = initialState, action = {}) {
switch(action.type) {
case PROFILE_IMAGE:

return {
...state,
url:action.payload
};
case PROFILE_ADDRESS:

return {
...state,
address:action.payload
};

case LOGOUT:
return {
...state,
isLogout:action.isLogout
};    
default:
return state;
}
}

