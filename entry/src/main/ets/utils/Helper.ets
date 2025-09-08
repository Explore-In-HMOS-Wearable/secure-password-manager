import { userAuth } from '@kit.UserAuthenticationKit';
import { logger } from '../common/Logger';
import { promptAction } from '@kit.ArkUI';
import { AssetItem } from '../model/AssetItem';

export function isReserveClickable(reserveAccount: string, reservePassword: string, reserveLabel: string): boolean {
  return reserveAccount !== '' && reservePassword !== '' && reserveLabel != '';
}

export function isUpdateClickable(reservePassword: string): boolean {
  return reservePassword !== '';
}

export async function getAuthTokenCallback(challenge: Uint8Array,
  callback: (isSuccess: boolean, challenge: Uint8Array) => void) {
  const authParam: userAuth.AuthParam = {
    challenge: challenge,
    authType: [userAuth.UserAuthType.PIN],
    authTrustLevel: userAuth.AuthTrustLevel.ATL3,
  };
  const widgetParam: userAuth.WidgetParam = {
    title: 'Please enter your lock screen password.',
  };
  try {
    let userAuthInstance = userAuth.getUserAuthInstance(authParam, widgetParam);
    userAuthInstance.on('result', {
      onResult(result) {
        logger.info('userAuthInstance callback result = ' + JSON.stringify(result));
        if (result.result === 12500000) {
          logger.info('userAuthInstance callback result success');
          callback(true, result.token)
        } else if (result.result === 12500010) {
          promptAction.showToast({ message: $r('app.string.please_set_pwd') })
          callback(false, new Uint8Array(0))
        }
      }
    });
    userAuthInstance.start();
  } catch (error) {
    logger.info('auth catch error: ' + JSON.stringify(error));
    promptAction.showToast({ message: $r('app.string.auth_failed') })
    callback(false, new Uint8Array(0))
  }
}

export function convertMapArrayToMapItem(array: Array<Map<string, string>>): Array<AssetItem>
{
  let res = new Array<AssetItem>();
  for (let dataElement of array) {
    let tmp: AssetItem = {
      alias: dataElement.get('alias') as string,
      secret: dataElement.get('secret') as string,
      dataLabel: dataElement.get('label') as string,
    };
    res.push(tmp)
  }
  return res;
}