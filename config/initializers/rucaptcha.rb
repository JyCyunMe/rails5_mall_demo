RuCaptcha.configure do
  # 配置 cache_store，类似 Rails 的 config.cache_store
  # 与其它的验证码库不同， RuCaptcha 将验证码 code 存放在后端，而不是 Session，以避免 Session 重放攻击
  # 你需要将 cache_store 配置在一个支持跨进程、跨服务器共享的地方，例如 Memcached, Redis 都可以
  # 不可以用 file_store, null_store 或者 memory_store
  # 因为这些存储方式无法跨进程或服务器，当多进程、服务器部署的时候验证码会验证不过。
  # self.cache_store = [:mem_cache_store, '127.0.0.1']
  # self.cache_store = [:redis_store, '127.0.0.1']
  self.cache_store = :memory_store
  #
  # Color style, default: :colorful, allows: [:colorful, :black_white]
  # self.style = :colorful
  # Custom captcha code expire time if you need, default: 2 minutes
  # self.expires_in = 120
  # [Requirement / 重要]
  # Store Captcha code where, this config more like Rails config.cache_store
  # default: Read config info from `Rails.application.config.cache_store`
  # But RuCaptcha requirements cache_store not in [:null_store, :memory_store, :file_store]
  # 默认：会从 Rails 配置的 cache_store 里面读取相同的配置信息，并尝试用可以运行的方式，用于存储验证码字符
  # 但如果是 [:null_store, :memory_store, :file_store] 之类的，你可以通过下面的配置项单独给 RuCaptcha 配置 cache_store
  # self.cache_store = :mem_cache_store
  # 如果想要 disable cache_store 的 warning，就设置为 true，default false
  # self.skip_cache_store_check = true
  # Chars length, default: 5, allows: [3 - 7]
  # self.length = 5
  # enable/disable Strikethrough.
  # self.strikethrough = true
  # enable/disable Outline style
  # self.outline = false
end