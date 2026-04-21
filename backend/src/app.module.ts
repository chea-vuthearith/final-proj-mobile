import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { UsersController } from './users.controller';
import { ClassesController } from './classes.controller';
import { AnnouncementsController } from './announcements.controller';
import { ChatsController } from './chats.controller';
import { MenuController } from './menu.controller';
import { OrdersController } from './orders.controller';

@Global()
@Module({
  imports: [],
  controllers: [
    UsersController,
    ClassesController,
    AnnouncementsController,
    ChatsController,
    MenuController,
    OrdersController,
  ],
  providers: [PrismaService],
  exports: [PrismaService],
})
export class AppModule {}