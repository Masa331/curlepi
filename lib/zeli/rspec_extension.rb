class Zeli
  module RSpecExtension
    def quack!(duck)
      process(duck.method, duck.url, params: duck.params, headers: duck.headers)
    end

    def extended_with_duck?
      true
    end
  end
end
