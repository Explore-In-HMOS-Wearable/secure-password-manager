import { ArcList, ArcListItem, ArcListItemAttribute } from '@kit.ArkUI';

@Entry
@Component
struct Page {

  @Builder
  ListBuilder(image: Resource, title: string, url: string) {
    ArcListItem() {
      Row({ space: 8 }) {
        Image(image).width(30).height(30).fillColor('#fff')
        Text(title).fontSize(18).fontWeight(FontWeight.Bold);
      }
      .backgroundColor('#ff55b1ff')
      .borderRadius(20)
      .padding(8)
      .width('100%')
      .onClick(() => {
        this.getUIContext().getRouter().pushUrl({
          url: url
        })
      })
    }
    .padding(16)
  }

  build() {
    Column() {
      ArcList({ initialIndex: 1 }) {
        ArcListItem() {
          Text($r('app.string.app_name'))
            .margin({ top: 20 })
            .wordBreak(WordBreak.BREAK_WORD)
            .width('70%')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
        }

        this.ListBuilder($r('app.media.add'), 'Add Password', 'pages/AddPage')
        this.ListBuilder($r('app.media.list'), 'List Passwords', 'pages/ListPage')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ff3e70f6')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .alignSelf(ItemAlign.Center)
  }
}
