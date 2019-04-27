import Gtk
import RxGtk
import RxSwift

var bag = DisposeBag()

let status = Application.run { app in
    var window = ApplicationWindowRef(application: app)
    var grid = Grid()
    var tentry = Entry()
    var bentry = Entry()
    let tlabel = Label(str: "Celsius:")
    let blabel = Label(str: "Farenheit:")
    grid.marginStart = 8
    grid.marginTop = 4
    grid.marginEnd = 8
    grid.marginBottom = 4
    grid.columnSpacing = 4
    grid.rowSpacing = 4
    grid.add(tlabel, tentry)
    grid.attachNextTo(child: blabel, sibling: tlabel, side: .bottom, width: 1, height: 1)
    grid.attachNextTo(child: bentry, sibling: tentry, side: .bottom, width: 1, height: 1)
    window.add(grid)
    window.title = "Hello, Rx"
    window.showAll()

    var updating = false
    tentry.rx.text.map { Double($0).map { $0*9/5 + 32 } }.bind {
        guard let value = $0, !updating else { return }
        updating = true
        bentry.text = "\(value)"
        updating = false
    }.disposed(by: bag)
    bentry.rx.text.map { Double($0).map { ($0-32)*5/9 } }.bind {
        guard let value = $0, !updating else { return }
        updating = true
        tentry.text = "\(value)"
        updating = false
    }.disposed(by: bag)
}

bag = DisposeBag()

guard let status = status else {
    fatalError("Could not create Application")
}
guard status == 0 else {
    fatalError("Application exited with status \(status)")
}
