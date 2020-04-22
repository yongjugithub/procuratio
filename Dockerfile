# 参考: https://docs.docker.com/compose/rails/
# ruby環境にnodejs(サーバーサイドでjavascriptを実行)とyarn、ER図の出力に必要なgraphvizを指定

FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs yarn graphviz

# workdirでファイルパスがない場合、自動でmkdirされるためmkdirは省略

WORKDIR /procuratio
COPY ./Gemfile /procuratio/Gemfile
COPY ./Gemfile.lock /procuratio/Gemfile.lock
RUN bundle install
COPY . /procuratio

# Add a script to be executed every time the container starts

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
