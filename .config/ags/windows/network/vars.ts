import Network from 'gi://AstalNetwork'
import { Variable } from 'astal'

export const connectToAp = Variable<Network.AccessPoint | undefined>(undefined)
export const revealNetwork = Variable(false)
