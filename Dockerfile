FROM ruby:3.0.0

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs

RUN mkdir /web-site-reminder
WORKDIR /web-site-reminder
COPY Gemfile /web-site-reminder/Gemfile
COPY Gemfile.lock /web-site-reminder/Gemfile.lock
RUN bundle install
COPY . /web-site-reminder

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh

# ENTRYPOINT: docker run 時に実行したいプロセスをentrypoint.shに書いておくと、毎回実行される。
# これを使わない場合は、docker runコマンドの引数に実行プロセスを指定する事もできる。
# ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
# CMD: コマンドを実行する
# docker runコマンドの引数に実行プロセスを指定した場合は、そちらが優先される
CMD ["rails", "server", "-b", "0.0.0.0"]