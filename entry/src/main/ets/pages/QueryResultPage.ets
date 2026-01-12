import { ArcList, ArcListItem } from '@kit.ArkUI';
import { logger } from '../common/Logger';
import { AssetItem } from '../model/AssetItem';
import {
  log,
  postQueryAssetPromise,
  preQueryAssetPromise,
  queryAuthAssetPromise
} from '../model/AssetModel';
import { convertMapArrayToMapItem, getAuthTokenCallback } from '../utils/Helper';


@Builder
export function QueryResultPageBuilder (){
  QueryResultPage()
}

@Entry
@Component
struct QueryResultPage {
  @State data: AssetItem = {
    alias: '',
    secret: '',
    dataLabel: ''
  };

  private challenge: Uint8Array = new Uint8Array;
  private authToken: Uint8Array = new Uint8Array;

  @State result: AssetItem = {
    alias: '',
    secret: '',
    dataLabel: ''
  }

  pageInfos: NavPathStack = new NavPathStack();


  aboutToAppear(): void {
    this.init()
  }

  async init() {
    if (this.data.alias.length > 0) {
      let challenge = await preQueryAssetPromise(this.data.alias);
      if (challenge.length === 0) {
        log($r('app.string.query_failed'))
        return
      }
      this.challenge = challenge
      getAuthTokenCallback(this.challenge, async (isSuccess: boolean, authToken: Uint8Array) => {
        if (isSuccess) {
          logger.info('get auth token success!')
          this.authToken = authToken

          let account = await queryAuthAssetPromise(this.data.alias, this.challenge, this.authToken);
          postQueryAssetPromise(this.challenge)
          this.challenge = new Uint8Array;
          this.authToken = new Uint8Array;
          this.result = convertMapArrayToMapItem(new Array<Map<string, string>>(account))[0];
        }
      });
    }
  }

  build() {

    NavDestination(){
    Column() {

      Column() {
        ArcList({ initialIndex: 1 }) {
          ArcListItem() {
            Text($r('app.string.account_info')).fontColor(Color.White).fontSize(18).fontWeight(FontWeight.Bold)
          }

          ArcListItem() {
            Column() {
              Row() {
                Text($r('app.string.account'))
                  .fontFamily('HarmonyHeiTi')
                  .fontSize(16)
                  .fontColor($r('app.color.app_background'))
                  .lineHeight(22)
                  .fontWeight(500)
                  .margin({ top: '2.3%', bottom: '1.1%' })


                Blank()

                Text(this.data.alias)
                  .opacity(0.6)
                  .fontFamily('HarmonyHeiTi')
                  .fontSize(16)
                  .fontColor(0x182431)
                  .lineHeight(19)
                  .fontWeight(400)
                  .baselineOffset(0)
                  .margin({ top: '2.3%', bottom: '1.1%' })

              }
              .width('86.7%')
              .height('15%')
              .justifyContent(FlexAlign.SpaceBetween)

              Line()
                .width('86.7%')
                .height('0.5vp')
                .margin({
                  left: '12vp',
                  right: '12vp'
                })
                .backgroundColor('#0D182431')

              if (this.result.secret) {
                Row() {
                  Text($r('app.string.secret'))
                    .fontFamily('HarmonyHeiTi')
                    .fontSize(16)
                    .fontColor($r('app.color.app_background'))
                    .lineHeight(22)
                    .fontWeight(500)
                    .textAlign(TextAlign.Start)
                    .padding({ top: '2.3%', bottom: '1.1%' })

                  Blank()
                  Text(this.result.secret)
                    .opacity(0.6)
                    .fontFamily('HarmonyHeiTi')
                    .fontSize(16)
                    .fontColor(0x182431)
                    .lineHeight(19)
                    .fontWeight(400)
                    .textAlign(TextAlign.End)
                    .padding({ top: '2.3%', bottom: '1.1%' })
                }.width('86.7%').height('15%')
              }
              Line()
                .width('86.7%')
                .height('0.5vp')
                .margin({
                  left: '12vp',
                  right: '12vp'
                })
                .backgroundColor('#0D182431')

              Row() {
                Text($r('app.string.label2'))
                  .fontFamily('HarmonyHeiTi')
                  .fontSize(16)
                  .fontColor($r('app.color.app_background'))
                  .lineHeight(22)
                  .fontWeight(500)
                  .baselineOffset(0)
                  .textAlign(TextAlign.Start)
                  .padding({ top: '2.3%', bottom: '1.1%' })

                Blank()
                Text(this.data.dataLabel)
                  .opacity(0.6)
                  .fontFamily('HarmonyHeiTi')
                  .fontSize(16)
                  .fontColor(0x182431)
                  .lineHeight(19)
                  .fontWeight(400)
                  .baselineOffset(0)
                  .textAlign(TextAlign.End)
                  .padding({ top: '2.3%', bottom: '1.1%' })
              }

              .width('86.7%').height('15%')
            }
            .margin({ left: 12, right: 12, bottom: 12 })
            .backgroundColor(0xFFFFFF).borderRadius(16)
          }

        }
      }
    }
    .width('100%').height('100%').backgroundColor($r('app.color.app_background'))
  }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {



      this.pageInfos = context.pathStack;

      try {

        this.data = (context.pathInfo.param as AssetItem);
        logger.info(`asset item data -> ${JSON.stringify(this.data)}`)

      } catch (e) {
        logger.error(`testTag onReady catch exception: ${JSON.stringify(e)}`);
      }

    })


  }

  pageTransition() {
    PageTransitionEnter({ type: RouteType.Push, duration: 300 })
      .slide(SlideEffect.Right)

    PageTransitionEnter({ type: RouteType.Pop, duration: 300 })
      .slide(SlideEffect.Left)

    PageTransitionExit({ type: RouteType.Push, duration: 300 })
      .slide(SlideEffect.Left)

    PageTransitionExit({ type: RouteType.Pop, duration: 300 })
      .slide(SlideEffect.Right)
  }
}