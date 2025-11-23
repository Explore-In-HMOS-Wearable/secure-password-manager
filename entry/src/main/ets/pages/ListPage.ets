import { logger } from '../common/Logger';
import {
  log,
  postQueryAssetPromise,
  preQueryAssetPromise,
  queryAssetPromise,
  queryAuthAssetPromise,
  removeAssetPromise
} from '../model/AssetModel'
import { convertMapArrayToMapItem, getAuthTokenCallback } from '../utils/Helper';
import { ArcList, ArcListAttribute, ArcListItem, ArcListItemAttribute, LengthUnit } from '@kit.ArkUI';
import { AssetItem } from '../model/AssetItem';
import { BusinessError } from '@kit.BasicServicesKit';


@Builder
export function ListPageBuilder (name: string, param: Object){
  ListPage()
}

@Entry
@Component
struct ListPage {
  @State account: string = '';
  @State label: string = '';
  @State challenge: Uint8Array = new Uint8Array;
  @State authToken: Uint8Array = new Uint8Array;
  @State assets: AssetItem[] = [];
  pageInfos: NavPathStack = new NavPathStack();

  async aboutToAppear(): Promise<void> {
    this.initData()
  }

  async initData() {
    let accountList = queryAssetPromise(this.account, this.label);
    accountList.then(data => {
      this.assets = convertMapArrayToMapItem(data)
      logger.debug(JSON.stringify(convertMapArrayToMapItem(data)))
    })
  }

  @Builder
  SwipeBuilder(item: AssetItem) {
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.del'))
        .width(25)
        .height(25)
        .fillColor(Color.White)
    }
    .margin({ left: 8 })
    .onClick(() => {
      animateTo({
        duration: 1000,
        curve: Curve.Smooth,
        iterations: 1,
        playMode: PlayMode.Normal,
      }, () => {
        removeAssetPromise(item.alias, item.dataLabel).then(() => {
          this.initData()
        })
      })
    })
  }

  build() {
    NavDestination() {

      Column() {
      ArcList({ initialIndex: 1 }) {
        ArcListItem() {
          Text($r('app.string.account_list')).fontSize(18).fontWeight(FontWeight.Bold)
        }

        if (this.assets.length === 0) {
          ArcListItem() {
            Text($r('app.string.no_account')).fontSize(16).fontColor('#aaa')
          }

        }
        ForEach(this.assets, (asset: AssetItem) => {
          ArcListItem() {
            Row() {
              Text(asset.alias).fontSize(18).fontWeight(FontWeight.Bold)
            }
            .onClick(() => {
              this.pageInfos.pushDestination({
                name: 'QueryResultPage', param: asset, onPop: (popInfo: PopInfo) => {
                  logger.info(`[pushDestination]last page is: ${popInfo.info.name}, result: ${JSON.stringify(popInfo.result)}`);

                }
              }).catch((error: BusinessError) => {
                logger.error(`[pushDestination]failed, error code = ${error.code}, error.message = ${error.message}.`)
              }).then(() => {
                logger.error('[pushDestination]success.');
              });

            })
            .padding({ left: 8, right: 8 })
            .borderRadius(20)
            .backgroundColor($r('app.color.list_item'))
            .width('90%')
            .height(30)
          }
          .swipeAction({
            end: {
              builder: () => {
                this.SwipeBuilder(asset)
              }
            }
          })

        })
      }
      .padding({ right: 16, left: 16 })
      .space({
        unit: LengthUnit.VP,
        value: 4
      })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.app_background'))

  }.width('100%')
  .height('100%')
  .hideTitleBar(true)
  .onReady((context: NavDestinationContext) => {
    this.pageInfos = context.pathStack;
})
  }
}