@Entry
@Component
struct Main {
  pageStack : NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageStack){
    }.onAppear(() => {
      this.pageStack.pushPathByName('Page', null, false);
    })
    .hideNavBar(true)
  }
}