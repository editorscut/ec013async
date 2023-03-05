class ToolDemo{
  private var number = 0
}

extension ToolDemo {
  @available(*, renamed: "demo1()")
  func demo1(completion: @escaping (Int, Bool) -> Void) {
    Task {
      let result = await demo1()
      completion(result.0, result.1)
    }
  }
  
  
  func demo1() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater))
  }
}
}

extension ToolDemo {
  @available(*, deprecated,
              message: "use the async version of demo2()")
  func demo2(completion: @escaping (Int, Bool) -> Void) {
    Task {
      let (number, isGreater) = await demo2()
      completion(number, isGreater)
    }
  }
  
  
  func demo2() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater)
  }
}

extension ToolDemo {
  func demo3() async -> (Int, Bool) {
    let numberBeforeChange = number
    try? await Task.sleep(for: .seconds(0.5))
    number = Int.random(in: 1...50)
    let isGreater = number > numberBeforeChange
    return (number, isGreater)
  }
}

extension ToolDemo {
  @available(*, renamed: "demo4()")
  func demo4(completion: @escaping (Int, Bool) -> ()) {
    Task {
      let numberBeforeChange = number
      try? await Task.sleep(for: .seconds(0.5))
      number = Int.random(in: 1...50)
      let isGreater = number > numberBeforeChange
      completion(number, isGreater)
    }
  }
  
  func demo4() async -> (Int, Bool) {
    return await withCheckedContinuation { continuation in
      demo4{ number, isGreater in
        continuation.resume(returning: (number, isGreater))
      }
    }
  }
  
}
