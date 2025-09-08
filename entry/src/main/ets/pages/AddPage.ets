import {
  ArcButton,
  ArcButtonOptions,
  ArcButtonPosition,
  ArcList,
  ArcListAttribute,
  ArcListItem,
  ArcListItemAttribute,
  ColorMetrics,
  LengthUnit
} from '@kit.ArkUI';
import { ArcButtonStyleMode } from '@ohos.arkui.advanced.ArcButton';
import { addAssetPromise } from '../model/AssetModel';

@Entry
@Component
struct AddPage {
  @State account: string = '';
  @State password: string = '';
  @State label: string = '';

  build() {
    Column() {
      ArcList() {
        // Account
        ArcListItem() {
          Column({ space: 4 }) {
            Row({ space: 4 }) {
              Text('*').fontColor(0xFFE84026).fontSize(18).fontWeight(FontWeight.Bold)
              Text($r('app.string.account')).fontSize(18).fontWeight(FontWeight.Bold)
            }

            TextInput({
              placeholder: $r('app.string.account'),
              text: this.account
            }).onChange((text) => {
              this.account = text
            })
          }.width('90%')
        }.autoScale(false)

        // Password
        ArcListItem() {
          Column({ space: 4 }) {
            Row({ space: 4 }) {
              Text('*').fontColor(0xFFE84026).fontSize(18).fontWeight(FontWeight.Bold)
              Text($r('app.string.password')).fontSize(18).fontWeight(FontWeight.Bold)
            }

            TextInput({
              placeholder: $r('app.string.password'),
              text: this.password
            }).onChange((text) => {
              this.password = text
            })
              .type(InputType.Password)
          }.width('90%')
        }.autoScale(false)

        // Label
        ArcListItem() {
          Column({ space: 4 }) {
            Row({ space: 4 }) {
              Text('*').fontColor(0xFFE84026).fontSize(18).fontWeight(FontWeight.Bold)
              Text($r('app.string.label2')).fontSize(18).fontWeight(FontWeight.Bold)
            }

            TextInput({
              placeholder: $r('app.string.label2'),
              text: this.label
            }).onChange((text) => {
              console.log(text)
              this.label = text
            })
          }.width('90%')

        }
        .autoScale(false)


        ArcButton({
          options: new ArcButtonOptions({
            label: $r('app.string.save'),
            position: ArcButtonPosition.BOTTOM_EDGE,
            styleMode: ArcButtonStyleMode.CUSTOM,
            backgroundColor: ColorMetrics.resourceColor('#ff55b1ff'),
            onClick: () => {
              addAssetPromise(this.account, this.password, this.label).then(() => {
                this.getUIContext().getRouter().back()
              })
            }
          })
        })

      }
      .space({
        value: 20,
        unit: LengthUnit.VP
      })
      .padding({
        left: 10, right: 10
      })

    }
    .backgroundColor($r('app.color.app_background'))
    .width('100%')
    .height('100%');
  }
}