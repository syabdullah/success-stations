import { PROFILE_IMAGE,PROFILE_ADDRESS } from './ReduxConstants';
export function updateUrl(url) {
return {
type: PROFILE_IMAGE,
payload: url
}
}

export function updateAddress(address) {
return {
type: PROFILE_ADDRESS,
payload: address
}
}


