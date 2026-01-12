export default class GlobalContext {
  private static instance: GlobalContext;
  private uiContext?: UIContext;
  private context?: Context;

  static getInstance() {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  public saveContext(context: Context) {
    this.context = context;
  }

  public getCustomContext() {
    return this.context;
  }

  public saveUIContext(context: UIContext) {
    this.uiContext = context;
  }

  public getUIContext() {
    return this.uiContext;
  }
}