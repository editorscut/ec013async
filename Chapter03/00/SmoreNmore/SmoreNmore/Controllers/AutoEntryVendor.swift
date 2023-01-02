class AutoEntryVendor {
  let delay: Double
  let isFilled: Bool
  private var count = 0
  
  init(delay: Double,
       isFilled: Bool = false) {
    self.delay = delay
    self.isFilled = isFilled
  }
}


